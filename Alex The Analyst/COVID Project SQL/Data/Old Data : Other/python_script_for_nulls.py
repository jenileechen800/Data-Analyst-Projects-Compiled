import pandas as pd
import numpy as np


# import os
# print("Current working directory:", os.getcwd())
# print("Files in this directory:")
# for file in os.listdir():
#     print("-", file)

# Load the CSV file
input_file = "Data/CovidDeaths.csv"
output_file = "CovidDeathsNulls.csv"

# Read the CSV
df = pd.read_csv(input_file, dtype=str)

# Replace empty strings and strings with only whitespace with NaN
df = df.replace(r'^\s*$', np.nan, regex=True)

# Replace NaN with the string 'NULL'
df = df.fillna('NULL')

# # Save the updated DataFrame to a new CSV
df.to_csv(output_file, index=False)