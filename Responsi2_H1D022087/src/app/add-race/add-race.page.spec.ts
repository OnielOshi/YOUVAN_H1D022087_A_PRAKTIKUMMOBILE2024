import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AddRacePage } from './add-race.page';

describe('AddRacePage', () => {
  let component: AddRacePage;
  let fixture: ComponentFixture<AddRacePage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(AddRacePage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
