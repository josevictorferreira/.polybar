#!/bin/sh

get_mic_default() {
    pactl get-default-source
}

is_mic_muted() {
    mic_name="$(get_mic_default)"

    pactl list sources | \
        awk -v mic_name="${mic_name}" '{
            if ($0 ~ "Name: " mic_name) {
                matched_mic_name = 1;
            } else if (matched_mic_name && /Mute/) {
                print $2;
                exit;
            }
        }'
}

get_mic_status() {
    is_muted="$(is_mic_muted)"

    if [ "${is_muted}" = "yes" ]; then
        printf "%s\n" "  "
    else
        printf "%s\n" "  "
    fi
}

listen() {
    get_mic_status

    LANG=EN; pactl subscribe | while read -r event; do
        if printf "%s\n" "${event}" | grep --quiet "source" || printf "%s\n" "${event}" | grep --quiet "server"; then
            get_mic_status
        fi
    done
}

toggle() {
    pactl set-default-source alsa_input.usb-Creative_Technology_Ltd_Sound_Blaster_X3_83F45B9EFD26F3C9-03.pro-input-0
    pactl set-default-source easyeffects_source 
    pactl set-source-mute easyeffects_source toggle
}


main() {
  case "$1" in
      --toggle)
          toggle
          ;;
      *)
          listen
          ;;
  esac
}

main "$@"
