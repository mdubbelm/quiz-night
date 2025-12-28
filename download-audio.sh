#!/bin/bash
# Script om muziekfragmenten te downloaden voor de nieuwjaarsquiz
# Vereist: yt-dlp en ffmpeg
# Installeren: brew install yt-dlp ffmpeg

set -e
cd "$(dirname "$0")/audio"

echo "🎵 Nieuwjaarsquiz Audio Downloader"
echo "=================================="

# Check of tools geïnstalleerd zijn
if ! command -v yt-dlp &> /dev/null; then
    echo "❌ yt-dlp niet gevonden. Installeer met: brew install yt-dlp"
    exit 1
fi

if ! command -v ffmpeg &> /dev/null; then
    echo "❌ ffmpeg niet gevonden. Installeer met: brew install ffmpeg"
    exit 1
fi

# Functie om een fragment te downloaden
download_fragment() {
    local num=$1
    local name=$2
    local video_id=$3
    local start=$4
    local duration=${5:-20}  # Standaard 20 seconden
    local output_file="${num}-${name}.m4a"

    if [ -f "$output_file" ]; then
        echo "✓ $output_file bestaat al, overslaan..."
        return
    fi

    echo ""
    echo "📥 Downloaden: $name"
    echo "   Video: https://youtube.com/watch?v=$video_id"
    echo "   Start: ${start}s, Duur: ${duration}s"

    # Download en knip in één stap
    yt-dlp \
        --extract-audio \
        --audio-format m4a \
        --audio-quality 0 \
        --download-sections "*${start}-$((start + duration))" \
        --output "temp_${name}.%(ext)s" \
        "https://www.youtube.com/watch?v=${video_id}" \
        2>/dev/null

    # Hernoem naar gewenste bestandsnaam
    mv "temp_${name}.m4a" "$output_file" 2>/dev/null || mv temp_${name}.* "$output_file" 2>/dev/null

    echo "   ✓ Opgeslagen als: $output_file"
}

echo ""
echo "🔄 Starten met downloaden..."

# Nummer 1: Die With A Smile - Lady Gaga & Bruno Mars
download_fragment "01" "die-with-a-smile" "kPa7bsKwL-c" 60 20

# Nummer 2: APT. - ROSÉ & Bruno Mars
download_fragment "02" "apt" "ekr2nIex040" 45 20

# Nummer 3: Lunch - Billie Eilish
download_fragment "03" "lunch" "i9FGPc5sXz8" 30 20

# Nummer 4: Espresso - Sabrina Carpenter
download_fragment "04" "espresso" "eVli-tstM5E" 55 20

# Nummer 5: Good Luck, Babe! - Chappell Roan
download_fragment "05" "good-luck-babe" "ApXoWvfEYVU" 50 20

echo ""
echo "=================================="
echo "✅ Klaar! Alle fragmenten staan in de audio/ map"
echo ""
echo "Bestanden:"
ls -la *.m4a 2>/dev/null || echo "   Geen bestanden gevonden"
