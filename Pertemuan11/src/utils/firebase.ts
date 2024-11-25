// src/utils/firebase.ts
import { initializeApp } from "firebase/app";
import { getAuth, GoogleAuthProvider } from "firebase/auth";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyClAmZZGBrHYAwlfbdxsj-qJfqC_fyvuVs",
  authDomain: "vue-firebase-a562a.firebaseapp.com",
  projectId: "vue-firebase-a562a",
  storageBucket: "vue-firebase-a562a.firebasestorage.app",
  messagingSenderId: "531381228625",
  appId: "1:531381228625:web:d07e37c4edb8e097d05470",
  measurementId: "G-NS02WX66S2",
};


const firebase = initializeApp(firebaseConfig);
const db = getFirestore(firebase);
const auth = getAuth(firebase);
const googleProvider = new GoogleAuthProvider();

export { auth, googleProvider, db };
