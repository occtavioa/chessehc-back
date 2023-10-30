import "dotenv/config"
import { MongoClient } from "mongodb"

export const client = new MongoClient(process.env.CONNECTION_STRING)
export const db = client.db("chessehc")

export async function getTournaments() {
    const tournaments = await db.collection("tournaments").find().toArray()
    return tournaments
}

export async function getTournamentById(id) {
    const tournament = await db.collection("tournaments").findOne({_id: id})
    return tournament
}

export async function getTournamentPlayers(tournamentId) {
    const {players} = await db.collection("tournaments").findOne({_id: tournamentId}, {players: 1})
    return players
}

export async function getTournamentPairingsByRound(tournamentId, roundNumber) {
    const {games, byes} = await db.collection("tournaments").findOne({_id: tournamentId}, {games: 1, byes: 1})
    return {games: games.filter(g => g.roundNumber === roundNumber), byes: byes.filter(b => b.roundNumber === roundNumber)}
}

export async function getTournamentStandingsByRound(tournamentId, roundNumber) {
    const {standings} = await db.collection("tournaments").findOne({_id: tournamentId}, {standings: 1})
    return standings.filter(s => s.roundNumber === roundNumber)
}
