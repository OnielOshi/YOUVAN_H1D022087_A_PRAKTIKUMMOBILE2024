#   tokokita

##  Proses Registrasi
a.  Input Data Registrasi
    Input Pengguna: Pengguna mengisi formulir registrasi dengan nama, email, dan password. Ini dilakukan pada antarmuka Flutter menggunakan TextFormField.
    Contohnya pada field Nama:
    '''dart
    Widget _namaTextField() {
        return TextFormField( // Membuat widget TextFormField untuk input nama
            decoration: const InputDecoration(labelText: "Nama"), // Menampilkan label "Nama"
            keyboardType: TextInputType.text, // Mengatur jenis keyboard untuk input teks
            controller: _namaTextboxController, // Menghubungkan controller untuk mengelola input
            validator: (value) { // Fungsi untuk memvalidasi input
            if (value!.length < 3) { // Memeriksa apakah panjang nama kurang dari 3 karakter
                return "Nama harus diisi minimal 3 karakter"; // Mengembalikan pesan kesalahan
            }
            return null; // Mengembalikan null jika validasi berhasil
            },
        );
        }
    ![Input Registrasi](registrasiInput.png)

b.  Validasi Registrasi
    Validasi: Formulir akan divalidasi untuk memastikan data yang dimasukkan memenuhi syarat tertentu, seperti panjang minimal untuk nama dan password, serta format email yang benar.
    Contohnya pada field email:
    Widget _emailTextField() {
        return TextFormField( // Membuat widget TextFormField untuk input email
            decoration: const InputDecoration(labelText: "Email"), // Menampilkan label "Email"
            keyboardType: TextInputType.emailAddress, // Mengatur jenis keyboard untuk input email
            controller: _emailTextboxController, // Menghubungkan controller untuk mengelola input
            validator: (value) { // Fungsi untuk memvalidasi input
            if (value!.isEmpty) { // Memeriksa apakah input email kosong
                return 'Email harus diisi'; // Mengembalikan pesan kesalahan jika kosong
            }
            // Validasi email menggunakan regex
            Pattern pattern = // Pola untuk validasi format email
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = RegExp(pattern.toString()); // Membuat objek RegExp dari pola
            if (!regex.hasMatch(value)) { // Memeriksa apakah input email sesuai dengan pola
                return "Email tidak valid"; // Mengembalikan pesan kesalahan jika tidak valid
            }
            return null; // Mengembalikan null jika validasi berhasil
            },
        );
        }

c.  Kirim Data
    Kirim Data: Jika semua data valid, pengguna menekan tombol registrasi, dan data dikumpulkan dan dikirim ke backend.
    _buttonRegistrasi() {
        return ElevatedButton( // Membuat tombol yang menggunakan ElevatedButton
            child: const Text("Registrasi"), // Menampilkan teks "Registrasi" di dalam tombol
            onPressed: () { // Mengatur aksi ketika tombol ditekan
            var validate = _formKey.currentState!.validate(); // Memvalidasi seluruh form
            if (validate) { // Jika validasi berhasil (true)
                _submit(); // Memanggil fungsi _submit() untuk mengirim data
            }
            },
        );
        }

d.  Simpan Data
    Simpan Data: Di backend, controller menerima data registrasi, mengenkripsi password, dan menyimpan informasi pengguna ke database.
    public function registrasi()
        {
            $data = [ // Menyimpan data registrasi dalam array
                'nama' => $this->request->getVar('nama'), // Mengambil nilai 'nama' dari permintaan
                'email' => $this->request->getVar('email'), // Mengambil nilai 'email' dari permintaan
                'password' => password_hash($this->request->getVar('password'), PASSWORD_DEFAULT) // Mengambil dan mengenkripsi 'password'
            ];

            $model = new MRegistrasi(); // Membuat instance dari model MRegistrasi
            $model->save($data); // Menyimpan data ke database menggunakan model
            return $this->responseHasil(200, true, "Registrasi Berhasil"); // Mengembalikan respons sukses
        }

e.  Notifikasi
    Notifikasi: Flutter menampilkan dialog kepada pengguna berdasarkan hasil registrasi. Jika berhasil, akan ada dialog sukses; jika gagal, dialog peringatan akan ditampilkan.
    showDialog( // Menampilkan dialog kepada pengguna
        context: context, // Mengatur konteks dialog agar sesuai dengan context saat ini
        barrierDismissible: false, // Mengatur agar dialog tidak bisa ditutup dengan mengetuk di luar dialog
        builder: (BuildContext context) => SuccessDialog( // Menentukan widget yang akan ditampilkan dalam dialog
            description: "Registrasi berhasil, silahkan login", // Pesan yang akan ditampilkan di dalam dialog
            okClick: () { // Aksi yang dilakukan ketika tombol "OK" di dalam dialog ditekan
            Navigator.pop(context); // Menutup dialog
            },
        ),
        );
