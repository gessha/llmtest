set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(PLUGIN "Model")

set(
    SRC
    plugin.cpp
    model.cpp
    common.cpp
    common-ggml.cpp
)

set(CMAKE_AUTOMOC ON)

add_library(${PLUGIN} MODULE ${SRC})
set_target_properties(${PLUGIN} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${PLUGIN})
qt5_use_modules(${PLUGIN} Qml Quick DBus)

execute_process(
    COMMAND dpkg-architecture -qDEB_HOST_MULTIARCH
    OUTPUT_VARIABLE ARCH_TRIPLET
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

## model requires ggml

# Find ggml include directory
find_path(GGML_INCLUDE_DIR NAMES ggml/ggml.h PATH_SUFFIXES include)

# Find ggml library
find_library(GGML_LIBRARIES NAMES ggml PATH_SUFFIXES lib)

message(STATUS "ggml include dir=${GGML_INCLUDE_DIR}")
message(STATUS "ggml lib=${GGML_LIBRARIES}")

# Check if ggml is found
if (GGML_INCLUDE_DIR AND GGML_LIBRARIES)
    include_directories(${GGML_INCLUDE_DIR})
    target_link_libraries(${PLUGIN} ${GGML_LIBRARIES})
else()
    message(FATAL_ERROR "ggml not found. Please make sure it is installed or provide the correct paths.")
endif()

## model requires ggml

set(QT_IMPORTS_DIR "/lib/${ARCH_TRIPLET}")

install(TARGETS ${PLUGIN} DESTINATION ${QT_IMPORTS_DIR}/${PLUGIN}/)
install(FILES qmldir DESTINATION ${QT_IMPORTS_DIR}/${PLUGIN}/)
