#!/bin/bash

# fungsi input file
function get_filename() {
	
	#buat variabel filename
	local filename=""


	while [[ -z "$filename" ]]; do
		read -p "Masukan nama file (tanpa ekstensi) : " filename
		if [[ -z "$filename" ]]; then
			echo  "Nama file tidak boleh kosong."
		fi
	done
	
	# simpan nilai inputan ke filename
	echo  "$filename"
}

# buat fungsi untuk menginput catatan
function get_catatan() {
	read -p "Masukan judul: " judul
	read -p "Masukan link: " link
	read -p "Masukan keterangan: " keterangan

	echo ""
	echo "Catatan Baru Anda"
	echo "======================= $judul ======================="
	echo "Judul: $judul"
	echo "Link: $link"
	echo "Keterangan: $keterangan"
	echo  "====================================================="
	echo ""
}

# memanggil fungsi catatan untuk mendapatkan file
filename=$(get_filename)
# buat varibel simpan nama file lengkap
full_filename="${filename}.txt"

# memeriksa apakah file sudah ada
if [[ -f "$full_filename" ]]; then
	echo  "File '$full_filename' sudah ada. Buat catatan anda saja."
else
	cd ~/Catatan

	touch "$full_filename"
	echo  "============================"
	echo  "File '$full_filename' telah dibuat."
	echo  "============================"
fi

# menginput judul, link dan keterangan
get_catatan

# Menentukan nomor catatan berikutnya
if [[ -s "$full_filename" ]]; then
	last_note_num=$(grep -o  '^[0-9]+' "$full_filename" | tail -n 1)
	note_num=$((last_note_num + 1))
else
	note_num=1
fi

# Menambahkan catatan kedalam file
echo "======================= $judul =======================" >> "$full_filename"
echo  "Judul: $judul" >> "$full_filename"
echo  "Link: $link" >> "$full_filename"
echo  "Keterangan: $keterangan" >> "$full_filename"

# Pesan berhasil membuat catatan
echo  "Catatan berhasil ditambahkan ke '$full_filename'."
