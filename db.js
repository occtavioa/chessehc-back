import "dotenv/config"
import { MongoClient } from "mongodb"

export const client = new MongoClient(process.env.CONNECTION_STRING)
export const db = client.db("chessehc")

export async function getTournaments() {
    const tournaments = db.collection("tournaments").find()
    return tournaments
}

export async function getTournamentById(id) {
    const tournament = await db.collection("tournaments").findOne({_id: id})
    return tournament
}

export async function getTournamentPlayers(tournamentId) {
    const players = await db.collection("players").findOne({tournament_id: tournamentId})
    return players
}

export async function getTournamentPairingsByRound(tournamentId, roundNumber) {
    const pairings = await db.collection("pairings").findOne({tournament_id: tournamentId, round_number: roundNumber})
    return pairings
}

export async function getTournamentStandingsByRound(tournamentId, roundNumber) {
    const standings = await db.collection("standings").findOne({tournament_id: tournamentId, round_number: roundNumber})
    return standings
}
