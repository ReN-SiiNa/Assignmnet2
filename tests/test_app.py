import pytest
from app import create_app

@pytest.fixture
def client():
    app = create_app()
    app.testing = True
    return app.test_client()

def test_home(client):
    response = client.get("/")
    assert response.status_code == 200
    assert b"Hello, Flask with Jenkins CI/CD!" in response.data
