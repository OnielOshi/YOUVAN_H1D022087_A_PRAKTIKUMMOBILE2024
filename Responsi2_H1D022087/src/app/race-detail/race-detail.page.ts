import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NavController } from '@ionic/angular';
import { RaceService } from '../services/race.service';

@Component({
  selector: 'app-race-detail',
  templateUrl: './race-detail.page.html',
  styleUrls: ['./race-detail.page.scss'],
})
export class RaceDetailPage implements OnInit {
  raceId: string;
  race: any = {};

  constructor(
    private route: ActivatedRoute,
    private raceService: RaceService,
    private router: Router,
    private navCtrl: NavController
  ) {
    this.raceId = this.route.snapshot.paramMap.get('id')!;
  }

  ngOnInit() {
    this.raceService.getRaceById(this.raceId).subscribe((data) => {
      this.race = data;
    });
  }

  updateRace() {
    this.raceService.updateRace(this.raceId, this.race);
    this.router.navigate(['/home']);
  }

  deleteRace() {
    this.raceService.deleteRace(this.raceId);
    this.router.navigate(['/home']);
  }

  goBack() {
    this.navCtrl.back(); // Kembali ke halaman sebelumnya
  }
}
