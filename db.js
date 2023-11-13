import "dotenv/config"
import mssql from "mssql"

const sqlConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    server: process.env.DB_SERVER,
    options: {
        trustServerCertificate: true
    }
}
const pool = await mssql.connect(sqlConfig).catch(e => {console.error(e);})

export async function getTournaments() {
    const request = new mssql.Request(pool)
    const result = await request.execute("GetTournaments")
    return result.recordset
}

export async function getTournamentById(id) {
    const request = new mssql.Request(pool)
    request.input("Id", mssql.Int, id)
    const result = await request.execute("GetTournamentById")
    return result.recordset.at(0)
}

export async function getTournamentPlayers(tournamentId) {
    const request = new mssql.Request(pool)
    request.input("TournamentId", mssql.Int, tournamentId)
    const result = await request.execute("GetTournamentPlayers")
    return result.recordset
}

export async function getTournamentGamesByRound(tournamentId, roundNumber) {
    const gamesResquest = new mssql.Request(pool)
    gamesResquest.arrayRowMode = true
    gamesResquest.input("TournamentId", mssql.Int, tournamentId)
    gamesResquest.input("RoundNumber", mssql.Int, roundNumber)
    const gamesResult = await gamesResquest.execute("GetTournamentGamesByRound")
    return gamesResult.recordset
}

export async function getTournamentByesByRound(tournamentId, roundNumber) {
    const byesRequest = new mssql.Request(pool)
    byesRequest.arrayRowMode = true
    byesRequest.input("TournamentId", mssql.Int, tournamentId)
    byesRequest.input("RoundNumber", mssql.Int, roundNumber)
    const byesResult = await byesRequest.execute("GetTournamentByesByRound")
    return byesResult.recordset
}

export async function getTournamentPairingsByRound(tournamentId, roundNumber) {
    const games = await getTournamentGamesByRound(tournamentId, roundNumber)
    const byes = await getTournamentByesByRound(tournamentId, roundNumber)
    return {games, byes}
}

export async function getTournamentStandingsByRound(tournamentId, roundNumber) {
    const request = new mssql.Request(pool)
    request.input("TournamentId", mssql.Int, tournamentId)
    request.input("RoundNumber", mssql.Int, roundNumber)
    const result = await request.execute("GetTournamentStandingsByRound")
    return result.recordset
}

export async function insertTournament(tournament) {
    const request = new mssql.Request(pool)
    request.input("Name", mssql.VarChar(50), tournament.name)
    request.input("NumberOfRounds", mssql.Int, tournament.numberOfRounds)
    request.input("CurrentRound", mssql.Int, tournament.currentRound)
    const result = await request.execute("InsertTournament")
    return result.recordset.at(0)
}

export async function insertPlayer(player) {
    const request = new mssql.Request(pool)
    request.input("TournamentId", mssql.Int, player.tournamentId)
    request.input("Name", mssql.VarChar(50), player.name)
    request.input("Rating", mssql.Int, player.rating)
    request.input("Title", mssql.VarChar(50), player.title)
    const result = await request.execute("InsertPlayer")
    return result.recordset.at(0)
}

export async function insertStanding({tournamentId, playerId, roundNumber, points}) {
    const request = new mssql.Request(pool)
    request.input("TournamentId", mssql.Int, tournamentId)
    request.input("PlayerId", mssql.Int, playerId)
    request.input("RoundNumber", mssql.Int, roundNumber)
    request.input("Points", mssql.Decimal(18, 1), points)
    const result = await request.execute("InsertPlayerPointsByRound")
    return result
}

export async function insertGame(game) {
    const request = new mssql.Request(pool)
    request.input("TournamentId", mssql.Int, game.tournamentId)
    request.input("Round", mssql.Int, game.round)
    request.input("WhiteId", mssql.Int, game.whiteId)
    request.input("BlackId", mssql.Int, game.blackId)
    request.input("WhitePoint", mssql.Int, game.whitePoint)
    request.input("BlackPoint", mssql.Int, game.blackPoint)
    request.input("Ongoing", mssql.Int, game.ongoing)
    const result = await request.execute("InsertGame")
    return result.recordset.at(0)
}

export async function insertBye(bye) {
    const request = new mssql.Request(pool)
    request.input("TournamentId", mssql.Int, bye.tournamentId)
    request.input("Round", mssql.Int, bye.round)
    request.input("PlayerId", mssql.Int, bye.playerId)
    request.input("ByePoint", mssql.Int, bye.byePoint)
    const result = await request.execute("InsertBye")
    return result
}
