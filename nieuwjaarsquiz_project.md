# Nieuwjaarsquiz 2025 - Project Samenvatting

## Doel
Een Kahoot-achtige multiplayer quiz voor Nieuwjaarsdag (1 januari 2026) over gebeurtenissen uit 2025.

## Features
- **Host-modus**: Voor TV/iPad - toont vragen, antwoorden, timer, scores
- **Speler-modus**: Voor telefoons - 4 gekleurde knoppen om te antwoorden
- **Multiplayer**: Via BroadcastChannel API (werkt alleen op zelfde netwerk/server)
- **4-letter spelcode** om mee te doen
- **20 vragen** over 2025 (15 nieuws + 5 muziek met YouTube clips)
- **Punten**: 100 base + (resterende tijd × 5)
- **Tussenstand** na elke 5 vragen
- **Confetti** bij eindstand

## Techniek
- Single HTML file (geen dependencies behalve YouTube embeds)
- BroadcastChannel API voor communicatie tussen apparaten
- Responsive design voor mobile + desktop

## Hoe te gebruiken

### Stap 1: Lokale server starten
```bash
cd ~/Downloads  # of waar het bestand staat
python3 -m http.server 8000
```

### Stap 2: IP-adres vinden
```bash
ipconfig getifaddr en0
```
Geeft bijv: `192.168.178.119`

### Stap 3: Spelen
1. **iPad (host)**: Ga naar `http://192.168.178.119:8000/nieuwjaarsquiz_2025.html`
2. Klik **"🖥️ Host"** → krijg een 4-letter code (bijv. "X7KM")
3. **Telefoons**: Zelfde URL, klik **"📱 Speler"**, voer code + naam in

**Let op**: Alle apparaten moeten op hetzelfde WiFi-netwerk zitten!

## Vragen in de quiz

### Nieuws 2025
1. Val kabinet-Schoof (PVV stapte uit juni 2025)
2. NAVO-top in Den Haag (eerste in NL)
3. Mark Rutte als NAVO secretaris-generaal
4. Rode Lijn demonstraties (250.000 mensen oktober)
5. Oscar voor "Ik Ben Geen Robot"
6. TK-verkiezingen 29 oktober
7. D66 ook 26 zetels (net als PVV)
8. Hitser populair bordspel
9. Televizier-Ring voor Vandaag Inside
10. Amsterdam 750 jaar
11. Natuurbranden Los Angeles januari
12. The Hague Pledge (NAVO defensienorm)
13. Memphis Depay topscoorder Oranje
14. Dacische goudschatten gestolen Drents Museum
15. Wilhelminatoren omgevallen Valkenburg

### Muziek 2025 (YouTube clips)
1. Die With A Smile - Lady Gaga & Bruno Mars
2. APT. - ROSÉ & Bruno Mars (Ordinary als vraag)
3. Birds of a Feather - Billie Eilish
4. Espresso - Sabrina Carpenter
5. Good Luck, Babe! - Chappell Roan

## Bekende issues
- QR-code library laadde niet (externe CDN geblokkeerd) → verwijderd
- BroadcastChannel werkt alleen als alle apparaten dezelfde origin hebben (dus via lokale server)

## Bestanden
- `/mnt/user-data/outputs/nieuwjaarsquiz_2025.html` - Werkende versie

## Vervolg in Claude Code
Om verder te werken in Claude Code terminal:

```bash
# Kopieer het bestand naar je project
cp ~/Downloads/nieuwjaarsquiz_2025.html ~/projects/nieuwjaarsquiz/

# Of download opnieuw en bewerk lokaal
```

Mogelijke verbeteringen:
- QR-code toevoegen (andere library of inline SVG)
- Meer vragen toevoegen
- Eigen muziekfragmenten (audio files ipv YouTube)
- WebSocket server voor echte multiplayer over internet
