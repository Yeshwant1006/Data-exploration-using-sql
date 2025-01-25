import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_excel('file path')

df['seater_count'] = df['seater_count'].apply(lambda x: int(x.split('-')[0]) if 'seater' in str(x) else None)

df['boot_space'] = df['boot_space'].apply(lambda x: float(str(x).split(' ')[0].replace('liters', '').replace('l', '').strip()) if 'liters' in str(x) else None)
df['tank_capacity'] = df['tank_capacity'].apply(lambda x: float(str(x).split(' ')[0].replace('liters', '').replace('l', '').strip()) if 'liters' in str(x) else None)

df['tank_capacity'].fillna(df['tank_capacity'].median(), inplace=True)
df['boot_space'].fillna(df['boot_space'].median(), inplace=True)
df['seater_count'].fillna(df['seater_count'].mode()[0], inplace=True)

fig, axes = plt.subplots(1, 3, figsize=(18, 10))

sns.barplot(x='company_name', y='seater_count', data=df, ax=axes[0], palette='Set2')
axes[0].set_title('Seater Count Across Brands')
axes[0].set_xlabel('Company Name')
axes[0].set_ylabel('Seater Count')
axes[0].tick_params(axis='x', rotation=90)

sns.barplot(x='company_name', y='boot_space', data=df, ax=axes[1], palette='Set2')
axes[1].set_title('Boot Space Across Brands (liters)')
axes[1].set_xlabel('Company Name')
axes[1].set_ylabel('Boot Space (liters)')
axes[1].tick_params(axis='x', rotation=90)

sns.barplot(x='company_name', y='tank_capacity', data=df, ax=axes[2], palette='Set2')
axes[2].set_title('Tank Capacity Across Brands (liters)')
axes[2].set_xlabel('Company Name')
axes[2].set_ylabel('Tank Capacity (liters)')
axes[2].tick_params(axis='x', rotation=90)

plt.suptitle('Exploring Vehicle Characteristics: Seater Count, Boot Space, and Tank Capacity Across Brands', fontsize=16)

plt.tight_layout(rect=[0, 0, 1, 0.96])

plt.show()
