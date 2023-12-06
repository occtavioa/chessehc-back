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
const newRequest = () => new mssql.Request(pool)

export async function getTournaments() {
    const request = newRequest()
    const result = await request.execute("GetTournaments")
    return result.recordset
}

export async function getTournamentById(id) {
    const request = newRequest()
    request.input("Id", mssql.Int, id)
    const result = await request.execute("GetTournamentById")
    return result.recordset.at(0)
}

export async function getTournamentPlayers(tournamentId) {
    const request = newRequest()
    request.input("TournamentId", mssql.Int, tournamentId)
    const result = await request.execute("GetTournamentPlayers")
    return result.recordset
}

export async function getPlayerById(id) {
    const request = newRequest()
    request.input("Id", mssql.Int, id)
    const result = await request.execute("GetPlayerById")
    return result.recordset
}

export async function getTournamentGamesByRound(tournamentId, round) {
    const gamesResquest = newRequest()
    gamesResquest.input("TournamentId", mssql.Int, tournamentId)
    gamesResquest.input("Round", mssql.Int, round)
    const gamesResult = await gamesResquest.execute("GetTournamentGamesByRound")
    return gamesResult.recordset
}

export async function getTournamentByesByRound(tournamentId, round) {
    const byesRequest = newRequest()
    byesRequest.input("TournamentId", mssql.Int, tournamentId)
    byesRequest.input("Round", mssql.Int, round)
    const byesResult = await byesRequest.execute("GetTournamentByesByRound")
    return byesResult.recordset
}

export async function getTournamentPairingsByRound(tournamentId, round) {
    const games = await getTournamentGamesByRound(tournamentId, round)
    const byes = await getTournamentByesByRound(tournamentId, round)
    return {games, byes}
}

export async function getTournamentStandingsByRound(tournamentId, round) {
    const request = newRequest()
    request.input("TournamentId", mssql.Int, tournamentId)
    request.input("Round", mssql.Int, round)
    const result = await request.execute("GetTournamentStandingsByRound")
    return result.recordset
}

export async function insertTournament(tournament) {
    const request = newRequest()
    request.input("Name", mssql.VarChar(50), tournament.name)
    request.input("NumberOfRounds", mssql.Int, tournament.numberOfRounds)
    request.input("CurrentRound", mssql.Int, tournament.currentRound)
    const result = await request.execute("InsertTournament")
    return result.recordset.at(0)
}

export async function insertPlayer(player) {
    const request = newRequest()
    request.input("TournamentId", mssql.Int, player.tournamentId)
    request.input("Name", mssql.VarChar(50), player.name)
    request.input("Rating", mssql.Int, player.rating)
    request.input("Title", mssql.VarChar(50), player.title)
    const result = await request.execute("InsertPlayer")
    return result.recordset.at(0)
}

export async function insertStanding(standing) {
    const request = newRequest()
    request.input("TournamentId", mssql.Int, standing.tournamentId)
    request.input("PlayerId", mssql.Int, standing.playerId)
    request.input("Round", mssql.Int, standing.roundNumber)
    request.input("Points", mssql.Decimal(18, 1), standing.points)
    const result = await request.execute("InsertPlayerPointsByRound")
    return result
}

export async function insertGame(game) {
    const request = newRequest()
    request.input("TournamentId", mssql.Int, game.tournamentId)
    request.input("Round", mssql.Int, game.round)
    request.input("WhiteId", mssql.Int, game.whiteId)
    request.input("BlackId", mssql.Int, game.blackId)
    request.input("WhitePoint", mssql.VarChar(50), game.whitePoint)
    request.input("BlackPoint", mssql.VarChar(50), game.blackPoint)
    request.input("Ongoing", mssql.Bit, game.ongoing)
    const result = await request.execute("InsertGame")
    return result.recordset.at(0)
}

export async function insertBye(bye) {
    const request = newRequest()
    request.input("TournamentId", mssql.Int, bye.tournamentId)
    request.input("Round", mssql.Int, bye.round)
    request.input("PlayerId", mssql.Int, bye.playerId)
    request.input("ByePoint", mssql.Int, bye.byePoint)
    const result = await request.execute("InsertBye")
    return result
}

export async function updateGameResult(id, whitePoint, blackPoint) {
    const request = newRequest()
    request.input("Id", mssql.Int, id)
    request.input("WhitePoint", mssql.VarChar(50), whitePoint)
    request.input("BlackPoint", mssql.VarChar(50), blackPoint)
    const result = await request.execute("UpdateGameResult")
    return result
}
