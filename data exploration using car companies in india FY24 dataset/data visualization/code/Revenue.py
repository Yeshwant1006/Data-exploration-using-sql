import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_excel('file path')

revenue_data = df.groupby(['company_name'])['estimated_revenue'].sum().reset_index()

plt.figure(figsize=(10, 6))
plt.plot(revenue_data['company_name'], revenue_data['estimated_revenue'], marker='o', linestyle='-', color='r')

plt.title('Estimated Revenue Analysis by Car Company in FY24', fontsize=16)
plt.xlabel('Company Name', fontsize=12)
plt.ylabel('Estimated Revenue', fontsize=12)

plt.xticks(rotation=90, fontsize=8)
plt.yticks(fontsize=8)
plt.tight_layout()

plt.show()
