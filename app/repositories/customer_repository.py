from typing import Protocol

from app.domain.customer import Customer


class CustomerRepository(Protocol):
    def list_customers(self) -> list[Customer]:
        raise NotImplementedError


class InMemoryCustomerRepository:
    def __init__(self) -> None:
        self._customers = [
            Customer(id=1, name="Carlos", email="carlos@example.com"),
            Customer(id=2, name="Diana", email="diana@example.com"),
        ]

    def list_customers(self) -> list[Customer]:
        return self._customers
