Pada Dataset ini ditemukan 2 Anomali :

1. Terdapat 118 baris dengan nilai decoy_noise negatif, yang secara logika tidak masuk akal karena noise umumnya merupakan penambahan Random secara positif atau aditif. Nilai negatif ini kemungkinan mengindikasikan kesalahan pada tahap pembuatan atau pemrosesan data.

2. Ditemukan 295 Extreme Outlier pada payment_value dan decoy_noise, yang diidentifikasi berdasarkan aturan tiga deviasi standar dari rata-rata. Jumlah yang cukup besar ini dapat mengindikasikan entri data yang salah, transaksi uji coba, atau bahkan bisa jadi merupakan Fraud Activity.

Kedua anomali tersebut menunjukkan adanya potensi masalah kualitas data yang bisa memengaruhi hasil analisis maupun kinerja model jika tidak ditangani dengan tepat, sehingga akan lebih baik jika dilakukan pembersihan pada Dataset sebelum melakukan Analisis lebih lanjut.