import e from "express";
import cors from "cors"
import * as db from "./db.js"
import * as middleware from "./middleware.js"

const app = e()
const port = 5000

app.use(cors())

app.get("/test", async(_, res) => {
    try {
        const result = await db.test()
        console.log("result: ", result);
        console.log("recordsets: ", result.recordsets);
        res.status(200).send(result)
    } catch(e) {
        console.error(e);
        res.sendStatus(500)
    }
})

app.get("/tournaments", async (_, res) => {
    try {
        const tournaments = await db.getTournaments()
        res.status(200).send(tournaments)
    } catch(e) {
        console.error(e)
        res.sendStatus(500)
    }
})

app.get("/tournaments/:id",
    middleware.validateTournamentId,
    async (req, res) => {
        try {
            const {id} = req.params
            const tournament = (await db.getTournamentById(parseInt(id))).at(0)
            tournament === undefined ? res.sendStatus(404) : res.status(200).send({
                id: tournament.Id,
                name: tournament.Name,
                numberOfRounds: tournament.NumberOfRounds,
                currentRound: tournament.CurrentRound
            })
        } catch(e) {
            console.error(e);
            res.sendStatus(500)
        }
    }
)

app.get("/tournaments/:id/players",
    middleware.validateTournamentId,
    async (req, res) => {
        try {
            const {id} = req.params
            const players = await db.getTournamentPlayers(parseInt(id))
            players === null ? res.sendStatus(404) : res.status(200).send(players.map(p => ({
                id: p.Id,
                name: p.Name,
                rating: p.Rating,
                title: p.Title,
                points: p.Points
            })))
        } catch(e) {
            console.error(e);
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
            const {games, byes} = await db.getTournamentPairingsByRound(parseInt(id), parseInt(roundNumber))
            games === null || byes === null ? res.sendStatus(404) : res.status(200).send({
                games: games.map(g => ({
                    id: g[0], round: g[1],
                    white: {id: g[2], name: g[3], rating:g[4], title: g[5], points: g[6]},
                    black: {id: g[7], name: g[8], rating:g[9], title: g[10], points: g[11]},
                    whitePoint: g[12],
                    blackPoint: g[13],
                    ongoing: g[14],
                })),
                byes: byes.map(b => ({
                    round: b[0],
                    player: {
                        id: b[1],
                        name: b[2],
                        rating: b[3],
                        points: b[4],
                        title: b[5]
                    },
                    byePoint: b[6]
                }))
            })
        } catch(e) {
            console.error(e);
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
            const standings = await db.getTournamentStandingsByRound(parseInt(id), parseInt(roundNumber))
            standings === null ? res.sendStatus(404) : res.status(200).send(standings.map(p => ({
                id: p.Id,
                name: p.Name,
                rating: p.Rating,
                title: p.Title,
                points: p.Points
            })))
        } catch(e) {
            console.error(e);
            res.sendStatus(500)
        }
    }
)

app.listen(port, () => {
    console.log("app listening on port", port);
})
