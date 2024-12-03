import { Injectable } from '@angular/core';
import { AngularFirestore } from '@angular/fire/compat/firestore';
import { AuthService } from './auth.service';
import { Observable } from 'rxjs';
import { switchMap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class RaceService {
  constructor(
    private firestore: AngularFirestore,
    private authService: AuthService
  ) {}

  addRace(race: any) {
    return this.authService.getUser().subscribe((user) => {
      if (user) {
        race.userId = user.uid;
        this.firestore.collection('races').add(race);
      }
    });
  }

  getRaces(): Observable<any[]> {
    return this.firestore
      .collection('races')  // Mengambil semua race, tanpa filter berdasarkan userId
      .valueChanges({ idField: 'id' });
  }

  getRaceById(raceId: string): Observable<any> {
    return this.firestore.collection('races').doc(raceId).valueChanges();
  }

  updateRace(raceId: string, race: any) {
    return this.firestore.collection('races').doc(raceId).update(race);
  }

  deleteRace(raceId: string) {
    return this.firestore.collection('races').doc(raceId).delete();
  }
}
