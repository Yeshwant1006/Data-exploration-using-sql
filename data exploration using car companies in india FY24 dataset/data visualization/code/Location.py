from types import FunctionType
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_excel('file path')

df['locations'] = df['manufacturing_locations_in_india'].str.split(',')
exploded_df = df.explode('locations')

exploded_df['locations'] = exploded_df['locations'].str.strip()

location_company_counts = exploded_df.groupby(['locations', 'company_name']).size().reset_index(name='count')

x = location_company_counts['locations']
y = location_company_counts['company_name']
size = location_company_counts['count'] * 100

plt.figure(figsize=(12, 8))

plt.scatter(x, y, s=size, alpha=0.7, c='orange', edgecolors="w", linewidth=0.5)

plt.title('Bubble Chart: Company Presence at Manufacturing Locations in India', fontsize=16)
plt.xlabel('Manufacturing Locations in India', fontsize=12)
plt.ylabel('Company Name', fontsize=12)

plt.xticks(rotation=90, ha="right", fontsize=10)
plt.yticks(fontsize=10)

plt.tight_layout()

plt.show()
