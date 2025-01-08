# qbittorrent-tracker-updater

A shell script that fetches public tracker lists and updates qBitorrent's "Automatically append these trackers to new downloads" list setting.

Does not update any torrents. For updating existing torrents, use [this](https://github.com/Jorman/Scripts?tab=readme-ov-file#addqbittorrenttrackerssh).

## Config

### Image

`ghcr.io/claabs/qbittorrent-tracker-updater`

### Environment Variables

| Variable       | Example                                                               | Default                                                                           | Description                                                                  |
|----------------|-----------------------------------------------------------------------|-----------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| QBT_USERNAME   | `username`                                                            | `admin`                                                                           | qBittorrent username                                                         |
| QBT_PASSWORD   | `password`                                                            | `adminadmin`                                                                      | qBittorrent password                                                         |
| QBT_ADDR       | `http://192.168.1.100:8080`                                           | `http://localhost:8080`                                                           | HTTP URL for the qBittorrent web UI, with port                               |
| URL_LIST       | `https://trackerslist.com/best.txt https://newtrackon.com/api/stable` | `https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt` | Space-separated list of tracker list URLs                                    |
| CRON_SCHEDULE  | `* * * * *`                                                           | `5 2 * * *`                                                                       | Cron schedule of when to run the job                                         |
| RUN_ON_STARTUP | `false`                                                               | `true`                                                                            | If true, runs the script immediately on startup, then schedules the cron job |
| RUN_ONCE       | `true`                                                                | `false`                                                                           | If true, does not schedule the cron job                                      |
| TZ             | `America/Chicago`                                                     | `UTC`                                                                             | Your timezone identifier                                                     |

## Development

### Build Image

`docker build . -t qbittorrent-tracker-updater`

### Run Container

`docker run --rm -it -e QBT_ADDR=http://192.168.1.100:8080 qbittorrent-tracker-updater`
