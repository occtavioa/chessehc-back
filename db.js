import "dotenv/config"
import { MongoClient } from "mongodb"

export const client = new MongoClient(process.env.CONNECTION_STRING)
export const db = client.db("chessehc")

export async function getTournaments() {
    return []
}

export async function getTournamentById(id) {
    return {}
}

export async function getTournamentPlayers(tournamentId) {
    return []
}

export async function getTournamentPairingsByRound(tournamentId, roundNumber) {
    return []
}

export async function getTournamentStandingsByRound(tournamentId, roundNumber) {
    return []
}
