const request = require('supertest');
const server = require('../app/server');

describe('GET /', () => {
  let srv;

  beforeAll(() => {
    srv = server.listen(0);
  });

  afterAll(() => {
    return srv.close();
  });

  test('responds 200 and contains title', async () => {
    const res = await request(srv).get('/');
    expect(res.statusCode).toBe(200);
    expect(res.text).toContain('GitHub Actions & CI/CD Demo');
  });
});
