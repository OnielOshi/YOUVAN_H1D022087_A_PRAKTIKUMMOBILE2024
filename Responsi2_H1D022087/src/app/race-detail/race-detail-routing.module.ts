import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { RaceDetailPage } from './race-detail.page';

const routes: Routes = [
  {
    path: '',
    component: RaceDetailPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class RaceDetailPageRoutingModule {}
