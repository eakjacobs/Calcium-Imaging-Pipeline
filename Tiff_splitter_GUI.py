from PyQt5.QtWidgets import *
from PyQt5.QtGui import QBrush, QColor
import sys
from skimage.external.tifffile import imread, TiffFile
import os
from skimage import io
#import tifffile as tiff
#from pathlib import Path, PureWindowsPath

file_dir = os.path.join("Z:","Elina_backup","zebrafish_data","2p")
#file_dir = Path("Z:\Elina_backup\zebrafish_data\2p")
print(file_dir)

file_locations = []
file_names = []


class selection_window(QWidget):
    global folder_locations
    global file_locations

    def __init__(self):
        super().__init__()
        self.setWindowTitle("Tiff Selector")

        self.layout = QGridLayout()
        self.setLayout(self.layout)

        self.tiff_list = QListWidget()
        self.add_tiff_button = QPushButton("Add Tiff")
        self.remove_tiff_button = QPushButton("Remove Tiff")
        self.split_tiffs_button = QPushButton("Split Tiffs")

        self.add_tiff_button.clicked.connect(self.add_tiff)
        self.split_tiffs_button.clicked.connect(self.split_all_tiffs)

        self.layout.addWidget(self.tiff_list, 0, 0, 5, 2)
        self.layout.addWidget(self.add_tiff_button, 0, 6 ,1, 1)
        self.layout.addWidget(self.remove_tiff_button, 1, 6, 1, 1)
        self.layout.addWidget(self.split_tiffs_button, 2, 6, 1, 1)

    def add_tiff(self):
        file_path   = QFileDialog.getOpenFileName(None, "Tiff Location: ", file_dir)[0]
        file_name   = os.path.basename(file_path)
        file_folder = file_dir
#        file_folder = os.path.dirname(file_path)

        print("File Name: ", file_name)
        print("File Location: ", file_folder)


        file_locations.append(file_folder)
        file_names.append(file_name)
        self.tiff_list.addItem(file_name)


    def split_all_tiffs(self):
        number_of_tiffs = len(file_names)

        for tiff in range(number_of_tiffs):
            print(file_locations[tiff])
            print(file_names[tiff])
            tiff_split(file_locations[tiff], file_names[tiff], 6)
            print("Fished Tiff: ", tiff)

        print("Fished All!")

def tiff_split(tiff_location, tiff_name, index_to_discard):

    # Create Folder For Split Tiff
    print(tiff_name.split(".")[0])
    if not os.path.isdir(os.path.join(tiff_location, "Split_Tiffs")):
        os.mkdir(os.path.join(tiff_location, "Split_Tiffs"))
    new_folder_location = os.path.join(tiff_location, "Split_Tiffs", tiff_name.split(".")[0])
    if not os.path.isdir(new_folder_location):
        print('creating folder for split tiffs')
        os.mkdir(new_folder_location, 0o755)

    # Load Tiff Into Array
    print("Opening File: ", tiff_name)
    full_filepath = os.path.join(tiff_location, tiff_name)
    print("Full file path: ", full_filepath)
#    img = tiff.imread(full_filepath)
    img = imread(full_filepath)
#    img = imread(tiff_location + "/" + tiff_name)

    total_images = img.shape[0]
    print("Number of Frames: ", total_images)


    # Split Tiff
    counter = 1                                     # Variable to Count Through All Original Tiffs
    names = 1                                       # Variable to Count Through Tiffs We Are Keeping
    for i in range(total_images):
        print("Frame: ", i, " of ", total_images)   # i loop through number of frames in each tif file
        if counter % index_to_discard == 0:         # if counter is divisible by index to discard, do not save
            counter += 1                            # counter iterate when it is at 6
        else:
            fname = new_folder_location
            io.imsave(arr=img[i, :, :], fname=new_folder_location + "/" + str(names).zfill(6) + ".tif")
            counter += 1  # else if not divisible by 6,all other values save the ith image in array and name
            names += 1  # iterate counter and also name, but not name if i=6 so we get consecutive named files



if __name__ == '__main__':
    app = QApplication([])

    tiff_selector = selection_window()
    tiff_selector.show()


    sys.exit(app.exec_())


