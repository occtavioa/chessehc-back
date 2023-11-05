export function validateTournamentId(req, res, next) {
    const {id} = req.params
    Number.isInteger(parseInt(id)) ? next() : res.sendStatus(400)
}

export function validateRoundNumber(req, res, next) {
    const {roundNumber} = req.params
    Number.isInteger(parseInt(roundNumber)) ? next() : res.sendStatus(400)
}
