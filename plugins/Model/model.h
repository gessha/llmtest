/*
 * Copyright (C) 2024  Georgi Georgiev
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * llmtest is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef MODEL_H
#define MODEL_H

#include <QObject>

#include "ggml/ggml.h"
#include "ggml/ggml-alloc.h"
#include "ggml/ggml-backend.h"

#include "common.h"
#include "common-ggml.h"

// default hparams (GPT-2 117M)
struct gpt2_hparams {
    int32_t n_vocab = 50257;
    int32_t n_ctx   = 1024;
    int32_t n_embd  = 768;
    int32_t n_head  = 12;
    int32_t n_layer = 12;
    int32_t ftype   = 1;
    float   eps     = 1e-5f;
};

struct gpt2_layer {
    // normalization
    struct ggml_tensor * ln_1_g;
    struct ggml_tensor * ln_1_b;

    struct ggml_tensor * ln_2_g;
    struct ggml_tensor * ln_2_b;

    // attention
    struct ggml_tensor * c_attn_attn_w;
    struct ggml_tensor * c_attn_attn_b;

    struct ggml_tensor * c_attn_proj_w;
    struct ggml_tensor * c_attn_proj_b;

    // mlp
    struct ggml_tensor * c_mlp_fc_w;
    struct ggml_tensor * c_mlp_fc_b;

    struct ggml_tensor * c_mlp_proj_w;
    struct ggml_tensor * c_mlp_proj_b;
};

struct gpt2_model {
    gpt2_hparams hparams;

    // normalization
    struct ggml_tensor * ln_f_g;
    struct ggml_tensor * ln_f_b;

    struct ggml_tensor * wte;     // position embedding
    struct ggml_tensor * wpe;     //    token embedding
    struct ggml_tensor * lm_head; // language model head

    std::vector<gpt2_layer> layers;

    // key + value memory
    struct ggml_tensor * memory_k;
    struct ggml_tensor * memory_v;

    //
    struct ggml_context * ctx_w;
    struct ggml_context * ctx_kv;

    ggml_backend_t backend = NULL;

    ggml_backend_buffer_t buffer_w;
    ggml_backend_buffer_t buffer_kv;

    std::map<std::string, struct ggml_tensor *> tensors;
};

class Model: public QObject {
    Q_OBJECT

public:
    Model();
    ~Model() = default;

    Q_INVOKABLE void speak(const QString &text);
    Q_INVOKABLE void load_model(const QString &model_name);
    Q_INVOKABLE void prompt(const QString &model_prompt);

private:
    gpt_params params;
    gpt_vocab vocab;
    gpt2_model model;
    ggml_backend_buffer_t buf_compute;
    ggml_gallocr_t allocr;

    bool gpt2_model_load(const std::string & fname, gpt2_model & model, gpt_vocab & vocab, int n_ctx, int n_gpu_layers);
    struct ggml_cgraph * gpt2_graph(
        const gpt2_model & model,
        const int n_past,
        const int n_tokens);
    bool gpt2_eval(
        const gpt2_model & model,
        ggml_gallocr_t allocr,
        const int n_threads,
        const int n_past,
        const std::vector<gpt_vocab::id> & embd_inp,
              std::vector<float>         & embd_w);
// signals:
//     // Signal to emit the capitalized text
//     void displayCapitalizedText(const QString &text);

// public slots:
};

#endif
