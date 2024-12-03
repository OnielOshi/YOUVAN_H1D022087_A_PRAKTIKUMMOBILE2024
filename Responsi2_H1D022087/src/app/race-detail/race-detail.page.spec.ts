import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RaceDetailPage } from './race-detail.page';

describe('RaceDetailPage', () => {
  let component: RaceDetailPage;
  let fixture: ComponentFixture<RaceDetailPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(RaceDetailPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
