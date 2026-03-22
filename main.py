from os import getenv

import uvicorn
from dotenv import load_dotenv

load_dotenv()

if __name__ == "__main__":
    uvicorn.run(
        "django_template.asgi:application",
        host=getenv("HOST", "0.0.0.0"),
        port=int(getenv("PORT", "8000")),
        reload=getenv("DJANGO_ENV", "development") != "production",
    )
