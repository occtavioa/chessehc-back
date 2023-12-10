import e from "express";
import cors from "cors"
import {default as tournamentsRouter} from "./routes/tournament.js";
import {default as playersRouter} from "./routes/players.js"
import {default as gamesRouter} from "./routes/games.js"
import {default as byesRouter} from "./routes/byes.js"
import {default as standingsRouter} from "./routes/standings.js"

const app = e()
const port = 5000

app.use(cors())
app.use(e.json())

app.get("/ping", (_req, res) => {
    res.status(200).send({message: "pong"})
})

app.use("/tournaments", tournamentsRouter)
app.use("/players", playersRouter)
app.use("/games", gamesRouter)
app.use("/byes", byesRouter)
app.use("/standings", standingsRouter)

app.listen(port, () => {
    console.log("app listening on port", port);
})
