import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

df = pd.read_excel('file path')

def average_mileage(mileage_str):
    if 'kmpl' in mileage_str:
        mileage_str = mileage_str.replace(' kmpl', '')
        mileage_range = mileage_str.split(' - ')

        try:
            lower = float(mileage_range[0].strip())
            upper = float(mileage_range[1].strip())
            return (lower + upper) / 2
        except ValueError:
            return np.nan
    return np.nan

df['average_mileage'] = df['mileage'].apply(average_mileage)

df = df.dropna(subset=['average_mileage'])

plt.figure(figsize=(30, 20))
sns.scatterplot(x='model_name', y='average_mileage', hue='company_name', data=df, palette='Set2', s=550)

plt.title('Relationship Between Mileage and Car Models Across Companies', fontsize=26)
plt.xlabel('Car Model', fontsize=24)
plt.ylabel('Average Mileage (km/l)', fontsize=24)
plt.xticks(rotation=90, ha='right', fontsize=20, rotation_mode='anchor')
plt.yticks(fontsize=20)
plt.tight_layout()

plt.legend(title='Company Name', title_fontsize='18', fontsize='16', loc='upper right', labelspacing=1.0)

plt.show()
