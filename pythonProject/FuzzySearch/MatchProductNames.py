import json
from fuzzywuzzy import fuzz
import os

class MatchProductNames:

    def __init__(self):
        self.deals_file_paths = {
            1: "amazonDeals.json",
            2: "flipkartDeals.json"
        }
        self.mapping_dataset = []

    def display_menu(self):
        """Get user input for dataset selection."""
        print("Select the dataset to compare with MasterData.json:")
        print("1. Amazon")
        print("2. Flipkart")
        print("3. Quit")
        # Add more options as needed

    def calculate_matching_percentage(self, str1, str2):
        """Calculate the matching percentage between two strings using fuzzy matching."""
        return fuzz.token_set_ratio(str1, str2)

    def find_best_match(self, master_product_title, master_product_category, master_product_subcategory, dataset, master_dataset_id, dataset_type):
        """Find the best matching product in the dataset based on fuzzy matching with master product title."""
        threshold = 70  # Adjust the threshold as per your requirement

        best_match_row_number = None
        best_match_percentage = 0

        for item in dataset:
            percentage = self.calculate_matching_percentage(master_product_title, item["ProductTitle"])
            if percentage >= threshold and percentage > best_match_percentage:
                best_match_row_number = item["RowNumber"]
                best_match_percentage = percentage

        if best_match_row_number is not None:
            mapping_data = {
                "Mapping_id": len(self.mapping_dataset) + 1,
                "Master_Product_Id": master_dataset_id,
                "Master_Product_Name": master_product_title,
                #"Master_Product_Category": master_product_category,
                #"Master_Product_SubCategory": master_product_subcategory,
                "Reference_DataSet_Id": best_match_row_number,  # Assuming the dataset ID is the same as masterDataset_Id for deals_dataset
                "Reference_DataSet_Type": dataset_type,
                "PercentageMatch": best_match_percentage
            }
            return mapping_data

        return None

    def load_data_from_json(self, file_path):
        """Load data from a JSON file and return as a Python dictionary."""
        with open(file_path, "r", encoding="utf-8") as file:
            data = json.load(file)
        return data

    def run(self):
        while True:
            try:
                os.system('cls')
                self.display_menu()
                choice = int(input("Enter the corresponding number: "))
                if choice == 3:
                    print("Good Bye")
                    exit()
                elif choice in self.deals_file_paths:
                    # Get user choice
                    selected_file_path = self.deals_file_paths[choice]
                    self.compare_with_masterdataset(selected_file_path)
                    print("Finished Processing !!!")
                else:
                    print("Invalid choice. Please select a valid option.")
            except ValueError:
                print("Invalid input. Please enter a number.")

    def compare_with_masterdataset(self, selected_file_path):

        # Load the selected dataset from JSON file
        deals_dataset = self.load_data_from_json(selected_file_path)

        # Load datasets from JSON files
        master_dataset = self.load_data_from_json("MasterData.json")

        for master_product in master_dataset:
            master_product_title = master_product["ProductTitle"]
            master_dataset_id = master_product["Master_RowNumber"]
            master_product_category = master_product["Category"]
            master_product_subcategory = master_product["SubCategory"]

            filtered_deals_dataset = [item for item in deals_dataset if self.calculate_matching_percentage(master_product_title, item["ProductTitle"]) >= 70]

            mapping_data = self.find_best_match(master_product_title, master_product_category, \
                                                master_product_subcategory, filtered_deals_dataset, master_dataset_id,\
                                                "Amazon")
            if mapping_data:
                self.mapping_dataset.append(mapping_data)

        # Write the mapping_dataset to mappingdataset.json
        with open("mappingdataset.json", "w", encoding="utf-8") as output_file:
            json.dump(self.mapping_dataset, output_file, indent=4)

        # Print the content of mappingdataset.json
        print("Content of mappingdataset.json:")
        with open("mappingdataset.json", "r", encoding="utf-8") as output_file:
            print(output_file.read())

if __name__ == "__main__":
    matchProductNames = MatchProductNames()
    matchProductNames.run()
