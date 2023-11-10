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

export async function getTournamentPairingsByRound(tournamentId, roundNumber) {
    const gamesResquest = new mssql.Request(pool)
    gamesResquest.arrayRowMode = true
    gamesResquest.input("TournamentId", mssql.Int, tournamentId)
    gamesResquest.input("RoundNumber", mssql.Int, roundNumber)
    const byesRequest = new mssql.Request(pool)
    byesRequest.arrayRowMode = true
    byesRequest.input("TournamentId", mssql.Int, tournamentId)
    byesRequest.input("RoundNumber", mssql.Int, roundNumber)
    const gamesResult = await gamesResquest.execute("GetTournamentGamesByRound")
    const byesResult = await byesRequest.execute("GetTournamentByesByRound")
    return {games: gamesResult.recordset, byes: byesResult.recordset}
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
    console.log(result);
    return result.recordset.at(0)
}

export async function test() {
    const request = new mssql.Request(pool)
    request.arrayRowMode = true
    const result = await request.execute("GetTournaments")
    return result
}
