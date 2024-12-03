import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { AuthGuard } from './auth.guard';

const routes: Routes = [
  {
    path: 'home',
    loadChildren: () =>
      import('./home/home.module').then((m) => m.HomePageModule),
    canActivate: [AuthGuard],
  },
  {
    path: 'login',
    loadChildren: () =>
      import('./login/login.module').then((m) => m.LoginPageModule),
  },
  {
    path: '',
    redirectTo: 'login',
    pathMatch: 'full',
  },
  {
    path: 'add-race',
    loadChildren: () => import('./add-race/add-race.module').then(m => m.AddRacePageModule)
  },
  {
    path: 'race-detail',
    loadChildren: () => import('./race-detail/race-detail.module').then(m => m.RaceDetailPageModule)
  },
  {
    path: 'race-detail/:id',
    loadChildren: () => import('./race-detail/race-detail.module').then(m => m.RaceDetailPageModule)
  },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules }),
  ],
  exports: [RouterModule],
})
export class AppRoutingModule {}
