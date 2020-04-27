import axios from 'axios'
import { omit } from 'ramda'
import clientStorage from '../services/clientStorage'

const buildRequest = (url, method, data, timeout) => {
  const options = {
    baseURL: process.env.API_URL,
    method,
    url,
    data,
    timeout,
  };
  const token = clientStorage.getAccessToken()
  if (token && token.length > 0) {
    options.headers = { Authorization: `Bearer ${token}` }
  };
  return axios.request(options)
};

const buildQuery =
  params =>
    Object.keys(params)
      .map(
        key => `${key}=${params[key]}`)
      .join('&');


const readFile = (file) => new Promise((resolve) => {
    const reader = new FileReader();
    reader.onload = () => {
      resolve(reader.result)
    };
    reader.readAsArrayBuffer(file)
  });

const uploadImage = async (file) => {
  const { data: { signedUrl } } = await buildRequest('/signed-url', 'post', {
    contentType: file.type,
  });
  const fileData = await readFile(file)
  await axios.put(signedUrl, fileData, {
    headers: {
      'Content-Type': file.type,
    },
  });
  return signedUrl.split('?')[0]
};

export default {
  authenticate:
    googleIdToken =>
      buildRequest('/admin/auth/google', 'post', { googleIdToken }),
  refreshToken:
    refreshToken =>
      buildRequest('/auth/refresh', 'post', { refreshToken }),

  getTournamentTotalSummary: () => buildRequest('/api/Tournaments/count-all', 'get'),
  getTournamentPrioritySummary: () => buildRequest('/api/Tournaments/count-prioritized', 'get'),

  getEventTotalSummary: () => buildRequest('/api/Events/count-all', 'get'),
  getEventPrioritySummary: () => buildRequest('/api/Events/count-prioritized', 'get'),
  getEventFavoriteSummary: () => buildRequest('/api/Events/count-favorite', 'get'),

  getMarketTotalSummary: () => buildRequest('/api/Markets/count-all', 'get'),
  getOddTotalSummary: () => buildRequest('/api/Markets/count-odds', 'get'),

  getLiveTotalSummary: () => buildRequest('/api/Events/count-upcominglive', 'get'),
  getLiveInPriorityTotalSummary: () => buildRequest('/api/Events/count--live-prioritized', 'get'),


  getSportSummary: () => buildRequest('/admin/sport/summary', 'get'),
  getSportTotalSummary: () => buildRequest('/api/Sports/count-all', 'get'),
  getSportPrioritySummary: () => buildRequest('/api/Sports/count-prioritized', 'get'),

  getEventSummary: () => buildRequest('/admin/event/summary', 'get'),
  filterUsersSummary:
    options =>
      buildRequest(`/admin/users/count?${buildQuery(options)}`, 'get'),
  filterSportSummary:
    options =>
      buildRequest(`/admin/sport/sum?${buildQuery(options)}`, 'get'),

  getSports:
    options =>
      buildRequest(`/api/sports?${buildQuery(options)}`, 'get'),

  getSportById: ({ id }) => buildRequest(`/api/sports/${id}`, 'get'),
  updateSport: ({ id, ...data }) =>
    buildRequest(`/api/sports/${id}`, 'put', data),



  getLatestSummary: () => buildRequest('/admin/sport/latest', 'get'),
  postContest:
    options =>
      buildRequest(
        `/admin/sport/summary?${buildQuery(options)}`,
        'post',
        null,
        1200000,
      ),

  getTournamentById: ({ id }) => buildRequest(`/api/tournaments/${id}`, 'get'),
  updateTournament: ({ id, ...data }) =>
    buildRequest(`/api/tournaments/${id}`, 'put', data),
  getTournamentsSummary: () => buildRequest('/api/tournaments', 'get'),

  getAllEvents: () => buildRequest('/api/events', 'get'),
  getEvents: ({ OrderColumn, OrderDirection })  =>
    buildRequest(`/api/events?OrderColumn=${OrderColumn}&OrderDirection=${OrderDirection}`, 'get'),
  getEvent: ({ id }) => buildRequest(`/api/events/${id}`, 'get'),
  updateEvent: ({ id, ...data }) =>
    buildRequest(`/api/events/${id}`, 'put', data),

  getAllFavorites: () => buildRequest('/api/events/favorite', 'get'),
  getFavorites: ({ OrderColumn, OrderDirection })  =>
    buildRequest(`/api/events/favorite?OrderColumn=${OrderColumn}&OrderDirection=${OrderDirection}`, 'get'),
  getFavorite: ({ id }) => buildRequest(`/api/events/${id}`, 'get'),
  updateFavorite: ({ id, ...data }) =>
    buildRequest(`/api/events/favorites/${id}`, 'put', data),


  getLives: ({ OrderColumn, OrderDirection })  =>
      buildRequest(`/api/events?OrderColumn=${OrderColumn}&OrderDirection=${OrderDirection}&SearchQuery=true&SearchColumn=upcomingLive`, 'get'),
    //getLives: ({ ...data }) => buildRequestLocalhost('/api/events', 'get', data),
    getLive: ({ id }) => buildRequest(`/api/events/${id}`, 'get'),


  updateLiveEvent: ({ id, ...data }) =>
    buildRequest(`/api/events/priority-live/${id}`, 'put', data),

  uploadImage,
}
