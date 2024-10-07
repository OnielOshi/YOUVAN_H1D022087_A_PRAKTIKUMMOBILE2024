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
    Validasi dilakukan menggunakan:

    validator: (value)

    if (value!.isEmpty) //digunakan untuk mengecek apakah field terisi

    if (!regex.hasMatch(value)) //unutk mengecek apakah email falid sesuai regex

    Mengirim Data:

    Jika semua field valid, method _submit() dipanggil.
    Form disimpan, dan loading indicator diaktifkan (_isLoading diatur ke true).
    Data dari form (nama, email, password) dikirim ke RegistrasiBloc untuk melakukan panggilan ke API.

    Menangani Respons:

    Jika registrasi berhasil (respons sukses), dialog sukses ditampilkan yang memberitahukan pengguna bahwa registrasi berhasil dan mereka dapat login.
    ![Berhasil Registrasi](registrasiBerhasil.png)
    Jika terjadi kesalahan (misalnya, email sudah terdaftar), dialog peringatan ditampilkan.

    Mengatur Status Loading:

    Setelah pengiriman data, loading indicator dinonaktifkan kembali (_isLoading diatur ke false).

##  Proses Login

1. Backend - API (CodeIgniter)

    Model MLogin

    Model ini berfungsi untuk berinteraksi dengan tabel member_token di database.
    Kolom yang diizinkan untuk diisi: member_id dan auth_key.

    Controller LoginController

    Method login():
    Data email dan password diambil dari permintaan (request).
    Mencari member dengan email menggunakan model MMember.
    Jika email tidak ditemukan, respons dikembalikan dengan status 400 dan pesan "Email tidak ditemukan".
    Jika email ditemukan tetapi password tidak valid (diperiksa menggunakan password_verify), respons dikembalikan dengan status 400 dan pesan "Password tidak valid".
    Jika berhasil login:
    Membuat token otentikasi (auth_key) menggunakan method RandomString().
    Menyimpan member_id dan auth_key ke dalam tabel member_token.
    Mengembalikan respons yang berisi token dan informasi pengguna (ID dan email).

2. Frontend - Flutter

    Model Login

    Model ini merepresentasikan data respons dari API saat login.
    Memiliki properti: code, status, token, userID, dan userEmail.
    Method fromJson() digunakan untuk mengonversi respons JSON menjadi objek Login.

    Halaman Login LoginPage

    Halaman ini berfungsi untuk menerima input dari pengguna.
    Terdapat dua field input:
    Email: Validasi untuk memastikan tidak kosong.
    Password: Validasi untuk memastikan tidak kosong.
    ![Input Login](loginInput.png)

    Proses Login:

    Form Validasi:

    Saat pengguna menekan tombol "Login", form divalidasi. Jika ada field yang tidak valid, pesan kesalahan ditampilkan.

    Mengirim Data:

    Jika validasi sukses, method _submit() dipanggil.
    Form disimpan, dan loading indicator diaktifkan (_isLoading diatur ke true).
    Data dari form (email dan password) dikirim ke LoginBloc untuk melakukan panggilan ke API.

    Menangani Respons:

    Jika login berhasil (status code 200), token dan ID pengguna disimpan menggunakan UserInfo untuk sesi pengguna.
    ![Berhasil Login](loginberhasil.png)
    Setelah berhasil, pengguna diarahkan ke halaman ProdukPage.
    Jika login gagal, dialog peringatan ditampilkan dengan pesan "Login gagal, silahkan coba lagi".

    Mengatur Status Loading:

    Setelah pengiriman data, loading indicator dinonaktifkan kembali (_isLoading diatur ke false).

    Bloc LoginBloc

    Method login():

    Mengambil URL API untuk login.
    Mengirim permintaan POST ke API dengan body yang berisi email dan password.
    Mengonversi respons JSON menjadi objek Login menggunakan method fromJson().

##  Produk Page


