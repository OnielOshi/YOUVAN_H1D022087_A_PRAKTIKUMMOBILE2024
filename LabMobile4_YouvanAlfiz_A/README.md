#   tokokita

##  Proses Registrasi
1. Backend - API (CodeIgniter)
Model MRegistrasi:

Model ini berfungsi untuk berinteraksi dengan tabel member di database.
Hanya tiga kolom yang diizinkan untuk diisi: nama, email, dan password.
Controller RegistrasiController:

Di dalam method registrasi(), data diambil dari permintaan (request) yang dikirim dari aplikasi Flutter.
Data yang diambil meliputi:
nama
email
password (yang di-hash menggunakan password_hash untuk keamanan).
Setelah data disiapkan, model MRegistrasi digunakan untuk menyimpan data tersebut ke dalam database.
Setelah penyimpanan berhasil, respons dikembalikan dengan status 200 dan pesan "Registrasi Berhasil".
2. Frontend - Flutter
Model Registrasi:

Model ini merepresentasikan data respons dari API.
Terdapat tiga properti: code, status, dan data, yang akan diisi berdasarkan respons JSON dari API.
Halaman Registrasi RegistrasiPage:

Halaman ini menyediakan form bagi pengguna untuk mengisi informasi registrasi.
Terdapat empat field:
Nama: Minimal 3 karakter.
Email: Harus diisi dan mengikuti format email yang valid.
Password: Minimal 6 karakter.
Konfirmasi Password: Harus sama dengan field password.
![Input Registrasi](registrasiInput.png)

Proses Registrasi:

Form Validasi:

Saat pengguna menekan tombol "Registrasi", form divalidasi. Jika ada field yang tidak valid, pesan kesalahan ditampilkan.

Mengirim Data:

Jika semua field valid, method _submit() dipanggil.
Form disimpan, dan loading indicator diaktifkan (_isLoading diatur ke true).
Data dari form (nama, email, password) dikirim ke RegistrasiBloc untuk melakukan panggilan ke API.
Menangani Respons:

Jika registrasi berhasil (respons sukses), dialog sukses ditampilkan yang memberitahukan pengguna bahwa registrasi berhasil dan mereka dapat login.
Jika terjadi kesalahan (misalnya, email sudah terdaftar), dialog peringatan ditampilkan.
Mengatur Status Loading:

Setelah pengiriman data, loading indicator dinonaktifkan kembali (_isLoading diatur ke false).
