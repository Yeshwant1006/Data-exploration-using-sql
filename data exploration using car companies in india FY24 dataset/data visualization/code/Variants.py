import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_excel('file path')

df['variants_count'] = df['variants'].apply(lambda x: len(str(x).split(',')))

variants_count = df.groupby('company_name')['variants_count'].sum().reset_index()

plt.figure(figsize=(10, 6))
sns.barplot(x='company_name', y='variants_count', data=variants_count, palette='viridis')

plt.title('Distribution of Variants Across Companies', fontsize=16)
plt.xlabel('Company Name', fontsize=12)
plt.ylabel('Total Number of Variants', fontsize=12)
plt.xticks(rotation=45, ha='right', fontsize=10)
plt.yticks(fontsize=10)
plt.tight_layout()

plt.show()
