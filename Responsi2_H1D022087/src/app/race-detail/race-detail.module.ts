import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { RaceDetailPageRoutingModule } from './race-detail-routing.module';

import { RaceDetailPage } from './race-detail.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RaceDetailPageRoutingModule
  ],
  declarations: [RaceDetailPage]
})
export class RaceDetailPageModule {}
