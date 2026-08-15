# ===========================================================
# YT-DLP SHORTCUTS
# ===========================================================

if ! command -v yt-dlp >/dev/null 2>&1; then
  print -u2 "yt-dlp: commande introuvable, fonctions yt-dlp désactivées"
  return 1
fi

typeset -gr  _YTDLP_DIR="$HOME/Vidéos/YouTube"
typeset -gr  _YTDLP_ARCHIVE_VIDEO="$HOME/Vidéos/.yt-dlp-archive-video.txt"
typeset -gr  _YTDLP_ARCHIVE_AUDIO="$HOME/Vidéos/.yt-dlp-archive-audio.txt"

typeset -gra _ytdlp_base=(
  --restrict-filenames
  --trim-filenames 150
  --embed-metadata
  --embed-thumbnail
)

typeset -gra _ytdlp_video=(
  "${_ytdlp_base[@]}"
  --merge-output-format mp4
  --write-subs
  --write-auto-sub
  --sub-lang fr
  --embed-subs
)

typeset -gra _ytdlp_video_list=(
  "${_ytdlp_video[@]}"
  --ignore-errors
  --download-archive "$_YTDLP_ARCHIVE_VIDEO"
)

typeset -gra _ytdlp_audio_list=(
  "${_ytdlp_base[@]}"
  --ignore-errors
  --download-archive "$_YTDLP_ARCHIVE_AUDIO"
)

ytdlp-help() {
  cat <<EOF
Commandes disponibles :

  ytdlp-onevideo720p  <URL>   Télécharge une vidéo en 720p
  ytdlp-onevideo1080p <URL>   Télécharge une vidéo en 1080p
  ytdlp-listvideo720p <URL>   Télécharge une playlist en 720p
  ytdlp-listvideo1080p <URL>  Télécharge une playlist en 1080p
  ytdlp-onemp3        <URL>   Télécharge une vidéo en MP3
  ytdlp-listmp3       <URL>   Télécharge une playlist en MP3

EOF
}

ytdlp-onevideo720p() {
  local url="$1"
  [[ -z "$url" ]] && { print -u2 "Usage: ytdlp-onevideo720p <URL>" ; return 1 }
  mkdir -p "$_YTDLP_DIR"
  yt-dlp --no-playlist \
    "${_ytdlp_video[@]}" \
    --download-archive "$_YTDLP_ARCHIVE_VIDEO" \
    --format "bestvideo[height<=720]+bestaudio/best[height<=720]" \
    --output "$_YTDLP_DIR/%(channel)s_-_%(title)s.%(ext)s" \
    "$url"
}

ytdlp-onevideo1080p() {
  local url="$1"
  [[ -z "$url" ]] && { print -u2 "Usage: ytdlp-onevideo1080p <URL>" ; return 1 }
  mkdir -p "$_YTDLP_DIR"
  yt-dlp --no-playlist \
    "${_ytdlp_video[@]}" \
    --download-archive "$_YTDLP_ARCHIVE_VIDEO" \
    --format "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
    --output "$_YTDLP_DIR/%(channel)s_-_%(title)s.%(ext)s" \
    "$url"
}

ytdlp-listvideo720p() {
  local url="$1"
  [[ -z "$url" ]] && { print -u2 "Usage: ytdlp-listvideo720p <URL>" ; return 1 }
  mkdir -p "$_YTDLP_DIR"
  yt-dlp --yes-playlist \
    "${_ytdlp_video_list[@]}" \
    --format "bestvideo[height<=720]+bestaudio/best[height<=720]" \
    --output "$_YTDLP_DIR/%(playlist_title)s/%(playlist_index)02d_-_%(title)s.%(ext)s" \
    "$url"
}

ytdlp-listvideo1080p() {
  local url="$1"
  [[ -z "$url" ]] && { print -u2 "Usage: ytdlp-listvideo1080p <URL>" ; return 1 }
  mkdir -p "$_YTDLP_DIR"
  yt-dlp --yes-playlist \
    "${_ytdlp_video_list[@]}" \
    --format "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
    --output "$_YTDLP_DIR/%(playlist_title)s/%(playlist_index)02d_-_%(title)s.%(ext)s" \
    "$url"
}

ytdlp-onemp3() {
  local url="$1"
  [[ -z "$url" ]] && { print -u2 "Usage: ytdlp-onemp3 <URL>" ; return 1 }
  mkdir -p "$_YTDLP_DIR"
  yt-dlp --no-playlist \
    "${_ytdlp_base[@]}" \
    --download-archive "$_YTDLP_ARCHIVE_AUDIO" \
    -x --audio-format mp3 \
    --output "$_YTDLP_DIR/%(channel)s_-_%(title)s.%(ext)s" \
    "$url"
}

ytdlp-listmp3() {
  local url="$1"
  [[ -z "$url" ]] && { print -u2 "Usage: ytdlp-listmp3 <URL>" ; return 1 }
  mkdir -p "$_YTDLP_DIR"
  yt-dlp --yes-playlist \
    "${_ytdlp_audio_list[@]}" \
    -x --audio-format mp3 \
    --output "$_YTDLP_DIR/%(playlist_title)s/%(playlist_index)02d_-_%(title)s.%(ext)s" \
    "$url"
}