from django.test import Client


def test_routes_with_auth_flow() -> None:
    client = Client()

    assert client.get("/docs").status_code == 200

    customer_response = client.get("/v1/customer")
    assert customer_response.status_code == 200

    login_response = client.get("/v1/auth/login")
    assert login_response.status_code == 200
    auth_header = login_response.headers.get("Authorization")
    assert auth_header is not None

    private_response = client.get("/v1/private", HTTP_AUTHORIZATION=auth_header)
    assert private_response.status_code == 200
