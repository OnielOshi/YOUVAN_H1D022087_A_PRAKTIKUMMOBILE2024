import { Component, OnInit } from '@angular/core';
import { ApiService } from '../service/api.service';
import { ModalController, AlertController } from '@ionic/angular';

@Component({
  selector: 'app-mahasiswa',
  templateUrl: './mahasiswa.page.html',
  styleUrls: ['./mahasiswa.page.scss'],
})
export class MahasiswaPage implements OnInit {
  dataMahasiswa: any;
  modalTambah: any;
  modalEdit: any;
  id: any;
  nama: any;
  jurusan: any;

  constructor(private api: ApiService, private modal: ModalController, private alertController: AlertController) {}

  ngOnInit() {
    this.getMahasiswa();
  }

  resetModal() {
    this.id = null;
    this.nama = '';
    this.jurusan = '';
  }

  openModalTambah(isOpen: boolean) {
    this.modalTambah = isOpen;
    this.resetModal();
    this.modalTambah = true;
    this.modalEdit = false;
  }

  openModalEdit(isOpen: boolean, idget: any) {
    this.modalEdit = isOpen;
    this.id = idget;
    this.ambilMahasiswa(this.id);
    this.modalTambah = false;
    this.modalEdit = true;
  }

  cancel() {
    this.modal.dismiss();
    this.modalTambah = false;
    this.modalEdit = false;
    this.resetModal();
  }

  getMahasiswa() {
    this.api.tampil('tampil.php').subscribe({
      next: (res: any) => {
        this.dataMahasiswa = res;
      },
      error: (err: any) => {
        console.error(err);
      },
    });
  }

  tambahMahasiswa() {
    if (this.nama !== '' && this.jurusan !== '') {
      const data = { nama: this.nama, jurusan: this.jurusan };
      this.api.tambah(data, 'tambah.php').subscribe({
        next: () => {
          this.resetModal();
          this.getMahasiswa();
          this.modalTambah = false;
          this.modal.dismiss();
        },
        error: (err: any) => {
          console.error('Gagal tambah mahasiswa', err);
        },
      });
    } else {
      console.log('Data masih kosong');
    }
  }

  async konfirmasiHapus(id: any) {
    const alert = await this.alertController.create({
      header: 'Konfirmasi Hapus',
      message: 'Apakah Anda yakin ingin menghapus data mahasiswa ini?',
      buttons: [
        {
          text: 'Batal',
          role: 'cancel',
        },
        {
          text: 'Hapus',
          role: 'destructive',
          handler: () => {
            this.api.hapus(id, 'hapus.php?id=').subscribe({
              next: () => {
                this.getMahasiswa();
                console.log('Berhasil menghapus data');
              },
              error: (err: any) => {
                console.error('Gagal menghapus data', err);
              },
            });
          },
        },
      ],
    });

    await alert.present();
  }

  ambilMahasiswa(id: any) {
    this.api.lihat(id, 'lihat.php?id=').subscribe({
      next: (res: any) => {
        this.id = res.id;
        this.nama = res.nama;
        this.jurusan = res.jurusan;
      },
      error: (err: any) => {
        console.error('Gagal mengambil data', err);
      },
    });
  }

  editMahasiswa() {
    const data = { id: this.id, nama: this.nama, jurusan: this.jurusan };
    this.api.edit(data, 'edit.php').subscribe({
      next: () => {
        this.resetModal();
        this.getMahasiswa();
        this.modalEdit = false;
        this.modal.dismiss();
      },
      error: (err: any) => {
        console.error('Gagal edit mahasiswa', err);
      },
    });
  }
}
