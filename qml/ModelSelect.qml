import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Lomiri.Components 1.3
import Qt.labs.folderlistmodel 2.12
// import Ubuntu.Components 1.3

Page {
	id: modelSelectPage
	anchors.fill: parent

	header: PageHeader {
	    id: header
	    title: i18n.tr('Model Select Page')
	}

	ColumnLayout {
		spacing: units.gu(2)
		anchors {
		    margins: units.gu(2)
		    top: header.bottom
		    left: parent.left
		    right: parent.right
		    bottom: parent.bottom
		}

		ListView {
			FolderListModel {
				id: folderModel
				folder: "/home/phablet/.local/share/llmtest.georgi/"
			}

			Component {
				id: fileDelegate
				Text {
					text: fileName
				}
			}

			model: folderModel
			delegate: fileDelegate
		}
	}
}