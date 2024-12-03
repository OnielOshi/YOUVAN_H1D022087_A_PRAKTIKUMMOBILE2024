import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { RaceService } from '../services/race.service';
import { AuthService } from '../services/auth.service';  // Pastikan mengimpor AuthService

@Component({
  selector: 'app-home',
  templateUrl: './home.page.html',
  styleUrls: ['./home.page.scss'],
})
export class HomePage implements OnInit {
  races: any[] = [];

  constructor(
    private raceService: RaceService,
    private authService: AuthService,  // Menambahkan AuthService di sini
    private router: Router
  ) {}

  ngOnInit() {
    this.loadRaces();
  }

  loadRaces() {
    this.raceService.getRaces().subscribe({
      next: (data: any[]) => {
        this.races = data;
      },
      error: (err) => {
        console.error('Error fetching races:', err);
      },
    });
  }

  // Logika untuk logout
  logout() {
    this.authService.logout().then(() => {
      this.router.navigate(['/login']);  // Arahkan ke halaman login setelah logout
    }).catch((err) => {
      console.error('Error during logout:', err);
    });
  }
}
