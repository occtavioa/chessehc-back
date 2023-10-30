import e from "express";
import cors from "cors"
import * as db from "./db.js"
import * as middleware from "./middleware.js"
import { ObjectId } from "mongodb";

const app = e()
const port = 5000

app.use(cors())

app.get("/tournaments", async (_, res) => {
    const tournaments = await db.getTournaments()
    res.status(200).send(tournaments)
})

app.get("/tournaments/:id",
    middleware.validateTournamentId,
    async (req, res) => {
        try {
            const {id} = req.params
            const tournament = await db.getTournamentById(new ObjectId(id))
            tournament === null ? res.sendStatus(404) : res.status(200).send(players)
        } catch {
            res.sendStatus(500)
        }
    }
)

app.get("/tournaments/:id/players",
    middleware.validateTournamentId,
    async (req, res) => {
        try {
            const {id} = req.params
            const players = await db.getTournamentPlayers(new ObjectId(id))
            players === null ? res.sendStatus(404) : res.status(200).send(players)
        } catch {
            res.sendStatus(500)
        }
    }
)

app.get("/tournaments/:id/pairings/:roundNumber",
    middleware.validateTournamentId, 
    middleware.validateRoundNumber,
    async (req, res) => {
        try {
            const {id, roundNumber} = req.params
            const pairings = await db.getTournamentPairingsByRound(new ObjectId(id), parseInt(roundNumber))
            pairings === null ? res.sendStatus(404) : res.status(200).send(pairings)
        } catch {
            res.sendStatus(500)
        }
    }
)

app.get("/tournaments/:id/standings/:roundNumber",
    middleware.validateTournamentId,
    middleware.validateRoundNumber,
    async (req, res) => {
        try {
            const {id, roundNumber} = req.params
            const standings = await db.getTournamentStandingsByRound(new ObjectId(id), parseInt(roundNumber))
            standings === null ? res.sendStatus(404) : res.status(200).send(standings)
        } catch {
            res.sendStatus(500)
        }
    }
)

app.listen(port, () => {
    console.log("app listening on port", port);
})
