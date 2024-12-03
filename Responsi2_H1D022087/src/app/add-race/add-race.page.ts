import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { NavController } from '@ionic/angular';
import { RaceService } from '../services/race.service';

@Component({
  selector: 'app-add-race',
  templateUrl: './add-race.page.html',
  styleUrls: ['./add-race.page.scss'],
})
export class AddRacePage {
  race = { title: '', description: '' };

  constructor(
    private raceService: RaceService,
    private router: Router,
    private navCtrl: NavController
  ) {}

  addRace() {
    this.raceService.addRace(this.race);
    this.router.navigate(['/home']);
  }

  goBack() {
    this.navCtrl.back(); // Arahkan ke halaman sebelumnya
  }
}
