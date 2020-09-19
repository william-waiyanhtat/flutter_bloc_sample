import 'albums_list.dart';
import 'spotify_error.dart';

class AlbumListReponse {
  AlbumsList albumsList;
  SpotifyError spotifyError;

  setSpotifyError(SpotifyError spotifyError) {
    this.spotifyError = spotifyError;
  }

  setAlbumList(AlbumsList albumsList) {
    this.albumsList = albumsList;
  }

  SpotifyError get error => spotifyError;
}
