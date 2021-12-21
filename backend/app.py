from starlette.applications import Starlette
from starlette.routing import Route
from starlette.responses import PlainTextResponse

app = Starlette(
    routes=[
        Route("/", PlainTextResponse("Hello, world!")),
    ],
)
