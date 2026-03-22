from django.http import JsonResponse
from ninja import NinjaAPI, Schema
from ninja.security import HttpBearer

from app.dependencies import get_auth_service, get_customer_service

api = NinjaAPI(title="Django Template API", version="1.0.0")


class JWTAuth(HttpBearer):
    def authenticate(self, request, token: str):  # type: ignore[override]
        try:
            payload = get_auth_service().decode_token(token)
            return payload
        except Exception:  # noqa: BLE001
            return None


class CustomerOut(Schema):
    id: int
    name: str
    email: str


@api.get("v1/customer", response=list[CustomerOut], tags=["v1"])
def list_customers(request):  # noqa: ARG001
    return [customer.__dict__ for customer in get_customer_service().list_customers()]


@api.get("v1/auth/login", tags=["v1"])
def login(request):  # noqa: ARG001
    token = get_auth_service().issue_token("demo-user")
    response = JsonResponse({"token": token})
    response["Authorization"] = f"Bearer {token}"
    response["X-JWT-Token"] = token
    return response


@api.get("v1/public", tags=["v1"])
def public(request):  # noqa: ARG001
    return {"message": "public endpoint"}


@api.get("v1/private", auth=JWTAuth(), tags=["v1"])
def private(request):
    subject = request.auth.get("sub") if request.auth else None
    return {"message": "private endpoint", "subject": subject}
