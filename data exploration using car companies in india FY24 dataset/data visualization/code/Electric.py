import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the dataset
df = pd.read_excel('/content/car companies.xlsx')

# Filter data for Electric Vehicles (EVs)
ev_df = df[df['fuel_type'] == 'Electric']

# 1. Line chart for EV sales over time
ev_sales_over_time = ev_df.groupby('first_sale_date')['no_of_units_sold_in_FY24'].sum()

# 2. Histogram for EV mileage (after converting 'mileage' to float and taking average)
# Convert 'mileage' from str to float but only keep valid 'km' values (exclude 'kmpl' values)

# First, extract the numeric part of the 'mileage' column
ev_df['mileage_numeric'] = ev_df['mileage'].str.extract('(\d+\.?\d*)').astype(float)

# Now, filter out values that are in 'kmpl' (by checking if 'kmpl' exists in the original string)
ev_df_filtered = ev_df[ev_df['mileage'].str.contains('km', case=False, na=False)]

# Take the average mileage for each model (EV cars only)
avg_mileage = ev_df_filtered.groupby('model_name')['mileage_numeric'].mean()

# 3. Bar chart for profitability of EV cars and highest selling model
ev_profit = ev_df.groupby('company_name').agg({'profit_by_model': 'sum', 'no_of_units_sold_in_FY24': 'sum'}).sort_values(by='profit_by_model', ascending=False)
ev_profit['highest_selling_model'] = ev_df.loc[ev_df.groupby('company_name')['no_of_units_sold_in_FY24'].idxmax(), 'model_name']

# 4. Pie chart for market share of EVs in the automobile industry
total_sales = df['no_of_units_sold_in_FY24'].sum()
ev_sales = ev_df['no_of_units_sold_in_FY24'].sum()

market_share = [ev_sales, total_sales - ev_sales]
labels = ['EV Cars', 'Other Cars']
colors = ['#4CAF50', '#FF5733']

# Plot all charts in one figure
fig, axs = plt.subplots(2, 2, figsize=(14, 10))

# Line chart for EV sales
axs[0, 0].plot(ev_sales_over_time.index, ev_sales_over_time.values, marker='o', color='b')
axs[0, 0].set_title('EV Sales Over Time', fontsize=14)
axs[0, 0].set_xlabel('Date', fontsize=12)
axs[0, 0].set_ylabel('Units Sold', fontsize=12)
axs[0, 0].tick_params(axis='x', labelsize=10)
axs[0, 0].tick_params(axis='y', labelsize=10)

# Histogram for EV mileage
# Plot the histogram of average mileage for Electric Vehicles
sns.histplot(avg_mileage, kde=True, color='green', ax=axs[0, 1])
axs[0, 1].set_title('EV Mileage vs Battery Capacity', fontsize=14)
axs[0, 1].set_xlabel('Mileage (km)', fontsize=12)
axs[0, 1].set_ylabel('Frequency', fontsize=12)

# Set font size for xticks and yticks and rotate xticks
axs[0, 1].tick_params(axis='x', labelsize=10, rotation=90)
axs[0, 1].tick_params(axis='y', labelsize=10)

# Bar chart for profitability of EV cars and highest selling model
ev_profit.plot(kind='bar', y='profit_by_model', ax=axs[1, 0], color='orange', legend=False)
axs[1, 0].set_title('Profitability of EV Cars by Company', fontsize=14)
axs[1, 0].set_ylabel('Profit', fontsize=12)

# Pie chart for market share of EVs in the automobile industry
axs[1, 1].pie(market_share, labels=labels, autopct='%1.1f%%', startangle=90, colors=colors)
axs[1, 1].set_title('Market Share of EV Cars', fontsize=14)

# Adjust layout
plt.tight_layout()
plt.show()
