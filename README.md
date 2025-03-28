# Tutorial 7 Game Development

Nama: Muhammad Nanda Pratama  
NPM: 2206081654

Berikut beberapa hal yang saya lakukan di tutorial 7 ini

### 1. Sistem Pergerakan Karakter
- Kontrol WASD untuk gerakan karakter
- Mouse look untuk rotasi kamera
- Ketinggian pandangan kamera yang proporsional dengan karakter

### 2. Fitur Sprint & Crouching
- **Sprinting**: Pemain dapat berlari dengan menekan Shift, meningkatkan kecepatannya
- **Crouching**: Pemain dapat jongkok dengan menekan C, mengurangi kecepatannya
- Saat jongkok, pemain:
  - Memiliki tinggi yang lebih rendah (collision shape dan mesh menyesuaikan)
  - Dapat melompat dengan kekuatan lompatan yang lebih rendah 
  - Tidak dapat berlari

### 3. Interaksi dengan Lingkungan
- Sistem interaksi dengan objek menggunakan RayCast3D
- Implementasi kelas Interactable untuk objek yang dapat diinteraksikan


### Fitur tutorial
- Contoh: Switch yang dapat mengontrol intensitas cahaya
- Sistem lompatan yang berbeda saat jongkok (crouch jump)
- Objek kotak fisik yang dapat didorong
- Sistem lampu dekoratif

## Cara Bermain
1. Gunakan WASD untuk bergerak
2. Gunakan mouse untuk melihat sekeliling
3. Tekan C untuk jongkok/berdiri
4. Tekan Shift untuk berlari (hanya saat berdiri)
5. Tekan Spasi untuk melompat
6. Tekan E untuk berinteraksi dengan objek
7. Capai sphere goal untuk menyelesaikan level
8. Jangan jatuh ke jurang

