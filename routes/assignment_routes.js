const express = require('express');
const assignmentController = require('../controllers/assignment_controller');
const auth = require('../controllers/authentication');

const router = express.Router();
router.get('/v3/assignments',auth,assignmentController.getAllAssignments)
router.post('/v3/assignments',auth,assignmentController.createAssignment)
router.post('/v3/assignments/:id/submission',auth,assignmentController.postSubmission)
router.get('/v3/assignments/:id',auth,assignmentController.getAssignment)
router.delete('/v3/assignments/:id',auth,assignmentController.deleteAssignment)
router.put('/v3/assignments/:id',auth,assignmentController.updateAssignment)
router.patch('/v3/assignments',auth,assignmentController.patch1)
router.patch('/v3/assignments/:id',auth,assignmentController.patch2)

module.exports = router
