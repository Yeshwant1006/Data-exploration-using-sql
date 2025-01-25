import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from matplotlib.colors import Normalize

# Load the dataset
df = pd.read_excel('/content/car companies.xlsx')

# Convert 'first_sale_date' to datetime
df['first_sale_date'] = pd.to_datetime(df['first_sale_date'])

# Extract month from 'first_sale_date'
df['sale_month'] = df['first_sale_date'].dt.month

# Group by model_name and sale_month, and count the number of sales
monthly_sales = df.groupby(['model_name', 'sale_month']).size().reset_index(name='sales_count')

# Create a color map for better visual distinction
colors = cm.viridis(Normalize()(monthly_sales['sales_count']))

# Plot the bubble chart
plt.figure(figsize=(27, 15))
plt.scatter(monthly_sales['model_name'], monthly_sales['sale_month'], 
            s=monthly_sales['sales_count'] * 1500,  # Scale bubble size for visibility
            c=monthly_sales['sales_count'], cmap='viridis', alpha=0.7)

plt.title('First Sale Date Across Models by Month', fontsize=18)
plt.ylabel('Month', fontsize=16)
plt.xlabel('Model Name', fontsize=16)
plt.colorbar(label='Number of Sales')
plt.xticks(rotation=90, fontsize=14)  # Rotate model names to fit them better on the x-axis
plt.yticks(range(1, 13), ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'], fontsize=14)
plt.tight_layout()  # To prevent clipping of tick labels
plt.show()

