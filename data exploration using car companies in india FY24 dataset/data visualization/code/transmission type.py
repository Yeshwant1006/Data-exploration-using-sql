import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_excel('file path')

transmission_count = df['transmission'].value_counts()

plt.figure(figsize=(10, 5))
plt.pie(transmission_count, labels=transmission_count.index, autopct='%1.1f%%', startangle=90, colors=['skyblue', 'lightgreen', 'yellow'],
        textprops={'fontsize': 8})

plt.title('Proportion of Car Models by Transmission Type', fontsize=16)

plt.show()
